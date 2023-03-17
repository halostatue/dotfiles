# Copy the return value of the passed-in block to the system clipboard
# copy { "I am now in the system clipboard" }
def copy
  value = yield
  IO.popen("pbcopy", "w") { |io| io.write(value) }
  nil
end

def paste
  IO.popen("pbpaste", "r").read
end
