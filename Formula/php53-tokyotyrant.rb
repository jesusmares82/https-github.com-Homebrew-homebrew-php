require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Tokyotyrant < AbstractPhp53Extension
  init
  desc "Provides a wrapper to the Tokyo Tyrant client library."
  homepage "https://pecl.php.net/package/tokyo_tyrant"
  url "https://pecl.php.net/get/tokyo_tyrant-0.7.0.tgz"
  sha256 "38559ac381670b61600d4736803a016f9e75aee9ae608d3f6b46e79103022d28"
  head "https://github.com/mkoppanen/php-tokyo_tyrant.git"

  bottle do
    sha256 "ff527d0a7ff3a5676eb56e659da94829519574f84b06638fa017005275d098b2" => :el_capitan
    sha256 "aaf2d28602221f2529bb4a8d4142e89feffe7ebc4002b5038e5a05459f222361" => :yosemite
    sha256 "1fc9558cc19504372fcf75aeef14d9cff101565827f61b12754d5d2cf402766f" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "tokyo-tyrant"

  def extension
    "tokyo_tyrant"
  end

  def install
    Dir.chdir "tokyo_tyrant-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/tokyo_tyrant.so"
    write_config_file if build.with? "config-file"
  end
end
