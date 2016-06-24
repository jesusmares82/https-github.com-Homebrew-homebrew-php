require File.join(File.dirname(__FILE__), 'homebrew-php-requirement')

class PhpMetaRequirement < HomebrewPhpRequirement
  if $supported_php_versions.nil?
    $supported_php_versions = %w{php53 php54 php55 php56 php71 php70}
  end

  if Formula["php53"].linked_keg.exist? && $supported_php_versions.include?('php53')
    default_formula "php53"
  elsif Formula["php54"].linked_keg.exist? && $supported_php_versions.include?('php54')
    default_formula "php54"
  elsif Formula["php55"].linked_keg.exist? && $supported_php_versions.include?('php55')
    default_formula "php55"
  elsif Formula["php56"].linked_keg.exist? && $supported_php_versions.include?('php56')
    default_formula "php56"
  elsif Formula["php70"].linked_keg.exist? && $supported_php_versions.include?('php70')
    default_formula "php70"
  elsif Formula["php71"].linked_keg.exist? && $supported_php_versions.include?('php71')
    default_formula "php71"
  else
    default_formula $supported_php_versions.last
  end

  def satisfied?
    $supported_php_versions.any? do |php|
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
