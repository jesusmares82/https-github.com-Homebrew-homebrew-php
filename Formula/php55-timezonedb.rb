require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Timezonedb < AbstractPhp55Extension
  init
  desc "Timezone Database to be used with PHP's date and time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2014.7.tgz"
  sha256 "76e1fba9ea263621810a220ffe280c8ca227a12fd497c9ce430537fbd13357a7"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "1c0ae7c89dcac57d6ebb4a8e48456a704e7b4a3e54e41451982d7aa859753991" => :el_capitan
    sha256 "2e0b1985051a597db94e128b05f94779bbc000a1c4aae85e8e8a32b66b67930a" => :yosemite
    sha256 "b4b49ce379137eb192919d0e3c71e3cd730276aebe5eeb238f8a33eae6eb634c" => :mavericks
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
