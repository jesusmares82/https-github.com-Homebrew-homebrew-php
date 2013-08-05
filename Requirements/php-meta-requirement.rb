require File.join(File.dirname(__FILE__), 'homebrew-php-requirement')

class PhpMetaRequirement < HomebrewPhpRequirement
  def satisfied?
    %w{php53 php54 php55}.any? do |php|
        f = Formula.factory(php)
        f.rack.directory? && f.rack.children.length > 0
    end
  end

  def message
    "Missing PHP53, PHP54 or PHP55 from homebrew-php. Please install one of them before continuing"
  end
end
