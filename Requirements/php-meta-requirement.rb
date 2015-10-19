require File.join(File.dirname(__FILE__), 'homebrew-php-requirement')

class PhpMetaRequirement < HomebrewPhpRequirement
  if Formula["php53"].linked_keg.exist?
    default_formula "php53"
  elsif Formula["php54"].linked_keg.exist?
    default_formula "php54"
  elsif Formula["php55"].linked_keg.exist?
    default_formula "php55"
  elsif Formula["php56"].linked_keg.exist?
    default_formula "php56"
  elsif Formula["php70"].linked_keg.exist?
    default_formula "php70"
  elsif !Formula["php56"].installed? 
    default_formula "php56"
  end

  def satisfied?
    %w{php53 php54 php55 php56 php70}.any? do |php|
        f = Formula[php]
        if f.linked_keg.exist?
          return true
        end
    end

    return false
  end

  def message
    "Missing a core php install from homebrew-php. Please run: brew link php56"
  end
end
