# frozen_string_literal: true

# Extends the String to add a String#each method so that
# strings can be read just like files, line-by-line.

class String
  def each(&block)
    split(/\n/).each(&block)
  end
end
