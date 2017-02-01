require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Timezonedb < AbstractPhp56Extension
  init
  desc "Timezone Database to be used with PHP's date and time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2016.10.tgz"
  sha256 "dc0a01830de85aec481d96ec7ec03b36814d02d1bc417f52ce655b2cb1eb7ede"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "2a6866ad11076814ae4e7ae06640dbdd669bf0f774cfbd9749b4684096d6ac41" => :sierra
    sha256 "e4fe064bbc7f6a2d742e3fdcd99eb43d66dc475284e4122781c10480fec0ad8a" => :el_capitan
    sha256 "bbfbe4fa1fec4722f44594d76fc73b041fa147d75df3289507d3cf4f8803f3fc" => :yosemite
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
