require File.join(File.dirname(__FILE__), 'homebrew-php-requirement')

class PhpMetaRequirement < HomebrewPhpRequirement
  if $supported_php_versions.nil?
    $supported_php_versions = %w{php53 php54 php55 php56 php70 php71 php72}
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
    <<-EOLTEXT.undent
    Missing a core php install from homebrew-php. 
    Please run: brew install php72
    or install another php version from the homebrew-php tap
    EOLTEXT
  end
end
