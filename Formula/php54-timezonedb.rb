require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Timezonedb < AbstractPhp54Extension
  init
  desc "Timezone Database to be used with PHP's date and time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2016.10.tgz"
  sha256 "dc0a01830de85aec481d96ec7ec03b36814d02d1bc417f52ce655b2cb1eb7ede"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "9681e5629d9a8071f643a3afc26a6d1eeef1e94f2dac7bac40c1264a1a7866ee" => :sierra
    sha256 "091695ee7ca7f78b6b2e0aea345e96548470610ce292116e09f47b368379bd09" => :el_capitan
    sha256 "d948618efea1be4f127fa26c03b349e77ebef0ecd2b151c54fce93bc671e6e75" => :yosemite
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
