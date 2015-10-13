require File.join(File.dirname(__FILE__), 'homebrew-php-requirement')

class PhpMetaRequirement < HomebrewPhpRequirement
  default_formula "php53" if Formula["php53"].linked_keg.exist?
  default_formula "php54" if Formula["php54"].linked_keg.exist?
  default_formula "php55" if Formula["php55"].linked_keg.exist?
  default_formula "php56" if Formula["php56"].linked_keg.exist?
  default_formula "php70" if Formula["php70"].linked_keg.exist?

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
