require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Timezonedb < AbstractPhp54Extension
  init
  desc "Timezone Database to be used with PHP's date and time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2014.7.tgz"
  sha256 "76e1fba9ea263621810a220ffe280c8ca227a12fd497c9ce430537fbd13357a7"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "79f41918aa50a9010af1b658ade40af4cc54708d8fb1e08f48259cf72d8f1c83" => :el_capitan
    sha256 "dc50e867e25209489723ae1b4469f40c830115bb77588321240fe50cd569a71e" => :yosemite
    sha256 "c5c56b66f0c67a0d75c1a755770462e69ef42e080a97da305854cf6323282e6d" => :mavericks
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
