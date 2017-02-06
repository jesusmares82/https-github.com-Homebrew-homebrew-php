require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Timezonedb < AbstractPhp71Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2016.10.tgz"
  sha256 "dc0a01830de85aec481d96ec7ec03b36814d02d1bc417f52ce655b2cb1eb7ede"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "398c88713083bb12c7a01698a908ea11d235ff1eed5f6d6fd18dfe2a398cda34" => :sierra
    sha256 "06b48e67dca8e620353f40c0c817d77fee1d9fc93ce099d473eadee08015dc61" => :el_capitan
    sha256 "d140374ae71cefc612f59d4e10ac623556d871d0c05e0d83e40c3ef02ea722ff" => :yosemite
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
