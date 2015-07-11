require File.join(File.dirname(__FILE__), 'homebrew-php-requirement')

class PhpMetaRequirement < HomebrewPhpRequirement
  def satisfied?
    %w{php53 php54 php55 php56 php70}.any? do |php|
        f = Formula[php]
        f.rack.directory? && f.rack.children.length > 0
    end
  end

  def message
    "Missing PHP53, PHP54, PHP55, PHP56, PHP70 from homebrew-php. Please install one of them before continuing"
  end
end
