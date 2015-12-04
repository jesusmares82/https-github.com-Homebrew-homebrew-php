require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Timezonedb < AbstractPhp56Extension
  init
  desc "Timezone Database to be used with PHP's date and time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2014.7.tgz"
  sha256 "76e1fba9ea263621810a220ffe280c8ca227a12fd497c9ce430537fbd13357a7"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "abb8092823e98ee9753fbcd0c19d65fb1679683635c0b7b4ee14ba526d054750" => :el_capitan
    sha256 "03a09630e3c5617fb9c59f20762f06efeec4564a72d3a1530ecafdcd351e3cf8" => :yosemite
    sha256 "5646b920eb8f8b379b012fbf81711fbb95be69c654e5f9bbc63704896aff461b" => :mavericks
  end

  def install
    Dir.chdir "timezonedb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/timezonedb.so"
    write_config_file if build.with? "config-file"
  end
end
