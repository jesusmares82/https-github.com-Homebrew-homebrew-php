require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Timezonedb < AbstractPhp70Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2016.10.tgz"
  sha256 "dc0a01830de85aec481d96ec7ec03b36814d02d1bc417f52ce655b2cb1eb7ede"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "90d9f1602e9ea85c6e542ed2e1a91247b216f8d4a916116c811a5a1c345cc4c4" => :sierra
    sha256 "667f75beed54158cc947935dd877e5329e4e907aac4e1ed08c5343e7e84631bd" => :el_capitan
    sha256 "66d55517ae20a1530b964b8f5da401e59b718f13430274257a2694aed7822647" => :yosemite
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
