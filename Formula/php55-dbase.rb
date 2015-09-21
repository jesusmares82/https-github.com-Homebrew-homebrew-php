require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Dbase < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/dbase/5.1.0"
  url "https://pecl.php.net/get/dbase-5.1.0.tgz"
  sha256 "20d6a40fb2efe4a06f503ec53512d02d71ceda87eac1f55208d7b5398f287a97"
  head "https://svn.php.net/repository/pecl/dbase/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "3b69e559b57216688c7d88df30d111eec4663221e78d94faed1c57dfc78ded41" => :el_capitan
    sha256 "91ff48015972cebaa05becfee97fb51e52b3d8ed328ede42fb7e0affaae2eea8" => :yosemite
    sha256 "86ac0cb084263aa172012e36716f6544c182237994904d960111629d3a209eaf" => :mavericks
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
