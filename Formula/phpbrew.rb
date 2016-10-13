require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpbrew < AbstractPhpPhar
  init
  desc "installs multiple version php(s) in your $HOME directory"
  homepage "https://github.com/phpbrew/phpbrew"
  url "https://github.com/phpbrew/phpbrew/raw/56300713fe9f99084a52987d624579d92c2b1844/phpbrew"
  version "1.22.5"
  sha256 "84301c766146bdc04f10e8cb0e8c2aefeaf943b0bea24ca42318a8f12c0aee1b"

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
