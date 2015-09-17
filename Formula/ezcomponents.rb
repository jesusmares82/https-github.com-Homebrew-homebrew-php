require 'formula'

class Ezcomponents < Formula
  url 'http://ezcomponents.org/files/downloads/ezcomponents-2009.2.1-lite.tar.bz2'
  homepage 'http://ezcomponents.org'
  sha256 'c7a4933dc8b100711c99cc2cc842da6448da35a4a95e8874342a92c79b8f8721'

  def install
    (lib+'ezc').install Dir['*']
  end

  def caveats; <<-EOS.undent
    The eZ Components are installed in #{HOMEBREW_PREFIX}/lib/ezc
    Remember to update your php include_path if needed
    EOS
  end

end
