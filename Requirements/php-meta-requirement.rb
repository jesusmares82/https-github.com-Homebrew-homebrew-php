require File.join(File.dirname(__FILE__), 'homebrew-php-requirement')

class PhpMetaRequirement < HomebrewPhpRequirement
  satisfy { which("php") }

  def message
    <<-EOLTEXT.undent
    Missing a core php install from homebrew-php. 
    Please run: brew install php72
    or install another php version from the homebrew-php tap
    EOLTEXT
  end
end
