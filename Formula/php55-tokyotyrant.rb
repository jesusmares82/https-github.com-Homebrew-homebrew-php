require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Tokyotyrant < AbstractPhp55Extension
  init
  desc "Provides a wrapper to the Tokyo Tyrant client library."
  homepage "https://pecl.php.net/package/tokyo_tyrant"
  url "https://pecl.php.net/get/tokyo_tyrant-0.7.0.tgz"
  sha256 "38559ac381670b61600d4736803a016f9e75aee9ae608d3f6b46e79103022d28"
  head "https://github.com/mkoppanen/php-tokyo_tyrant.git"

  bottle do
    sha256 "bf743c1da3bed26e8e410cddfcd39ec9f2a129750e99c8f1fb8969600aa8f27a" => :el_capitan
    sha256 "905d6b800a083c548ed181e7bc71224585e403efee6056d0a80668bb7e44b59b" => :yosemite
    sha256 "62b53cef163c3896bec765778916078307f43f09e6fd1172a5400a2d07d13a37" => :mavericks
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
