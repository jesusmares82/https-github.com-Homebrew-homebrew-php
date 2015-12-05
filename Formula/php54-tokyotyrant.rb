require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Tokyotyrant < AbstractPhp54Extension
  init
  desc "Provides a wrapper to the Tokyo Tyrant client library."
  homepage "https://pecl.php.net/package/tokyo_tyrant"
  url "https://pecl.php.net/get/tokyo_tyrant-0.7.0.tgz"
  sha256 "38559ac381670b61600d4736803a016f9e75aee9ae608d3f6b46e79103022d28"
  head "https://github.com/mkoppanen/php-tokyo_tyrant.git"

  bottle do
    sha256 "efc6beaabd0b5f12a98c10ce09298da2161e67340f5ec41c289b17cd070b78b0" => :el_capitan
    sha256 "66bc9e5669a0bdc350bb61b7a37ef348d162dd8914e9ab53bfb8c637fc91d345" => :yosemite
    sha256 "d0e89f86cc02859231771a914cd9b78cb53f2a0bbab3082a9ef647fd3ae79b1b" => :mavericks
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
