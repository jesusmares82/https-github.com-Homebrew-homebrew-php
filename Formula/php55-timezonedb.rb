require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Timezonedb < AbstractPhp55Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2016.10.tgz"
  sha256 "dc0a01830de85aec481d96ec7ec03b36814d02d1bc417f52ce655b2cb1eb7ede"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "7e35834e561430c596492bf78323ec067a89d4278f762ac393918da41bce5c24" => :sierra
    sha256 "37b94a6f49f9d27c887ee46463bc7bb643e8d885d882dc15f1c5aac2934035d9" => :el_capitan
    sha256 "feab418f8f66b18f17587b90765a850f5b9e19d88892272bbdd4281882a67b3f" => :yosemite
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
