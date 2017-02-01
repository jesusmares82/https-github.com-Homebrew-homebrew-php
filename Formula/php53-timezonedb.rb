require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Timezonedb < AbstractPhp53Extension
  init
  desc "Timezone Database to be used with PHP's date and time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2016.10.tgz"
  sha256 "dc0a01830de85aec481d96ec7ec03b36814d02d1bc417f52ce655b2cb1eb7ede"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "271fbd756e5de3a89ee788a6c9a8df08f6c275c9e162747a448133dff6e511fa" => :sierra
    sha256 "ae74e86585728505d6ffe24cd92c803d91ad8ffe89df1f4b02ff000a54f06572" => :el_capitan
    sha256 "107e7b70af3efe1d16dabe6da0f919c8a3a53fdbc279c4f4a7928052ae06ff11" => :yosemite
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
