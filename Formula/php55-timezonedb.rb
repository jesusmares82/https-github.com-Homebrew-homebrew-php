require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Timezonedb < AbstractPhp55Extension
  init
  desc "Timezone Database to be used with PHP's date and time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2016.10.tgz"
  sha256 "dc0a01830de85aec481d96ec7ec03b36814d02d1bc417f52ce655b2cb1eb7ede"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "1744cfb1ddf2aaf60b9e64e9d3779df31d05716e376368b237d6e3037e37a558" => :sierra
    sha256 "e810674a0a9a5c09e0f4680e928bff3fe8740b9e848ffdab1443c5e4085fd639" => :el_capitan
    sha256 "55f2f92060b736f2bcc6243c671825cee85899dd21f04f7fc706963d07c4a0a3" => :yosemite
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
