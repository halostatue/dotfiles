def Array.toy(n = 10, &block)
  Array.new(n, &block || -> { _1 + 1 })
end

def Hash.toy(n = 10)
  Array.toy(n) { (97 + _1).chr }.zip(Array.toy(n)).to_h
end

def maybe
  yield
rescue Exception => ex # standard:disable Lint/RescueException
  ex
end

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  def own_methods
    (methods - Object.instance_methods - Object.methods).sort
  end
end

if defined?(ObjectSpace)
  # Generate the class inheritance tree, in ASCII.
  def classtree(root = self.class, options = {})
    colourize = options.fetch(:colour, RUBY_PLATFORM !~ /win32|mingw/)

    output =
      if options.fetch(:copy, false)
        colourize = false
        StringIO.new
      else
        options.fetch(:output, $stdout)
      end

    indentation = " " * options.fetch(:indentation, 4)
    show = options.fetch(:show, :mixins)

    # get children of root
    children = {}
    maxlength = root.to_s.length
    ObjectSpace.each_object(Class) do
      if root != _1 && _1.ancestors.include?(root)
        (children[_1.superclass] ||= []) << _1
        maxlength = _1.to_s.length if _1.to_s.length > maxlength
      end
    end
    maxlength += 3

    # print nice ascii class inheritance tree
    (c = {}).default = ""
    if colourize
      c[:lines] = "\033[34;1m"
      c[:dots] = "\033[31;1m"
      c[:class_names] = "\033[33;1m"
      c[:module_names] = "\033[32;1m"
      c[:method_names] = "\033[39;m"
    end

    rprint = ->(current_root, prefix) {
      ind_s = maxlength - current_root.to_s.length

      if show == :methods # show methods, not mixins
        output.puts prefix.tr("`", "|")
        methods = current_root.instance_methods(false).sort
        strings = methods.map {
          if children[current_root].nil?
            s = " " * maxlength
          else
            ind = " " * (maxlength - indentation.length - 1)
            s = "#{c[:lines]}#{indentation}|#{ind}"
          end

          "#{prefix.tr("`", " ")}#{s}#{c[:dots]}:.. #{c[:method_names]}#{_1}"
        }

        strings[0] = "#{prefix}#{c[:lines]}- #{c[:class_names]}#{current_root} #{c[:dots]}"

        unless methods.first.nil?
          ind = "." * ind_s
          strings[0] << "#{ind} #{c[:method_names]}#{methods[0]}"
        end

        output << strings.join("\n")
      else
        s = "#{prefix}#{c[:lines]}- #{c[:class_names]}#{current_root}"

        if show == :mixins
          modules = current_root.included_modules - [Kernel]
          if modules.size > 0
            ind = " " * ind_s
            s << "#{ind}#{c[:lines]}[ #{c[:module_names]}"
            s << modules.join("#{c[:lines]}, #{c[:module_names]}")
            s << "#{c[:lines]} ]"
          end
        end

        output << s
      end

      output << "\n"

      if !children[current_root].nil?
        children[current_root].sort_by!(&:to_s)
        children[current_root].each do
          s = (_1 == children[current_root].last) ? "`" : "|"
          rprint.call(_1, "#{prefix.tr("`", " ")}#{indentation}#{c[:lines]}#{s}")
        end
      end
    }

    rprint.call(root, "")

    if options[:copy]
      pbcopy(output.string)
    else
      (output == $stdout) ? nil : output
    end
  end

  # Generate the class inheritance tree, in ASCII,
  def classtree_methods(root = self.class, options = {})
    classtree(root, options.merge({show: :methods}))
  end
end

def pbcopy(input)
  require "open3"

  input =
    case input
    when String
      input
    when StringIO
      input.string
    else
      input.pretty_print_inspect
    end

  Open3.popen3("pbcopy") do |stdin, _stdout, _stderr, _wait|
    stdin << input
  end

  nil
end
