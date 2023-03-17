def load_gem(library)
  library = {library => library} if library.is_a?(String)
  library.each_pair do |gem_name, require_name|
    gem gem_name if gem_name
    require require_name
    yield if block_given?
  rescue LoadError
    if gem_name == require_name
      warn "Error loading #{gem_name}"
    else
      warn "Error loading #{gem_name} (require '#{require_name}')"
    end
  rescue
    warn "Error loading #{gem_name}"
  end
end

def load_gems(libraries)
  libraries.each { |library| load_gem(library) }
end
