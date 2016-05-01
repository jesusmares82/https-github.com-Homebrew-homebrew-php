require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpbrew < AbstractPhpPhar
  init
  desc "installs multiple version php(s) in your $HOME directory"
  homepage "https://github.com/phpbrew/phpbrew"
  url "https://github.com/phpbrew/phpbrew/raw/fb208f6570969e4ca050657a3322bccd65cca6fd/phpbrew"
  version "1.21.1"
  sha256 "bbad349681684a921a4a5b24c9bb361e19d1e0d30720955d945394ced57b3570"

  bottle do
    cellar :any_skip_relocation
    sha256 "53da318cf43c2b2765b69f43cd892bfc86380148ec7dacf1e97d58d5161e6256" => :el_capitan
    sha256 "f720e053428bed9c6f063e7057df4579308e7200ee6c4142aa9fed40c11c4d67" => :yosemite
    sha256 "234bbed134cd60fbbf50a6d7d8e7081560eac761b3bcb1aa95f729f80dca0781" => :mavericks
  end

  depends_on "curl"
  depends_on "gettext"
  depends_on "gmp"
  depends_on "jpeg"
  depends_on "libevent"
  depends_on "libxml2"
  depends_on "icu4c"
  depends_on "mcrypt"
  depends_on "mhash"
  depends_on "pcre"
  depends_on "re2c"

  def phar_file
    "phpbrew"
  end

  def caveats; <<-EOS.undent
    phpbrew is now installed!

    To start using it, please run
      `phpbrew init`

    You can change phpbrew home with PHPBREW_ROOT and PHPBREW_HOME env vars
    EOS
  end
end
