require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Timezonedb < AbstractPhp53Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2016.10.tgz"
  sha256 "dc0a01830de85aec481d96ec7ec03b36814d02d1bc417f52ce655b2cb1eb7ede"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "4fd233f679b853b82355072323a0c013562354bf3c8c6ed24f85d446302f5d6b" => :sierra
    sha256 "7616d0d677b95d8e9aa3dbb9b199d4ca1503185b4e3c06228d5ebfaceadbc2ea" => :el_capitan
    sha256 "0982382cce9b00f87061a310564d3b9338fa98f1d873f7f834611c1e9ce60857" => :yosemite
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
