require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Dbase < AbstractPhp53Extension
  init
  desc "dBase database file access functions"
  homepage "https://pecl.php.net/package/dbase"
  url "https://pecl.php.net/get/dbase-5.1.0.tgz"
  sha256 "20d6a40fb2efe4a06f503ec53512d02d71ceda87eac1f55208d7b5398f287a97"
  head "https://svn.php.net/repository/pecl/dbase/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "ed205bcc1df9594e244adcf0c680f989af341f849efb9a2d156715e97d22b1b8" => :el_capitan
    sha256 "d5511e20aa859fdd1033ac0ec1dd1329d07558429b6278b70aff74a83beecec0" => :yosemite
    sha256 "c79897e83521e2f869f1ed42dfd2e938031d231f48ba9030ba80711a71c6bcc8" => :mavericks
  end

  def install
    Dir.chdir "dbase-5.1.0"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}"

    system "make"
    prefix.install "modules/dbase.so"
    write_config_file if build.with? "config-file"
  end
end
