require File.join(File.dirname(__FILE__), 'homebrew-php-requirement')

class PhpMetaRequirement < HomebrewPhpRequirement
  default_formula "php56"

  def satisfied?
    %w{php53 php54 php55 php56 php70}.any? do |php|
        f = Formula[php]
        f.linked_keg.exist?
    end
  end

  def message
    "Missing a core php install from homebrew-php. Please run: brew install php56"
  end
end
