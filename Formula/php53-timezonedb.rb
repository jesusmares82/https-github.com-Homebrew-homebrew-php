require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Timezonedb < AbstractPhp53Extension
  init
  desc "Timezone Database to be used with PHP's date and time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2014.7.tgz"
  sha256 "76e1fba9ea263621810a220ffe280c8ca227a12fd497c9ce430537fbd13357a7"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "bfef1a882dcb239af54f732ed222b03bde93b604e18c66bf2ab65511225c6175" => :el_capitan
    sha256 "940a91a621c42be5c3a4eab1d56a7a54a6c27d1f5a18762c51413457bcea9423" => :yosemite
    sha256 "f3f317b41bd608998a48f6d5875ff33fc023643e11587300374503ad425dd66b" => :mavericks
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
