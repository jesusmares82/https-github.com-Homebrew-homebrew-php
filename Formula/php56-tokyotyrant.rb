require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Tokyotyrant < AbstractPhp56Extension
  init
  desc "Provides a wrapper to the Tokyo Tyrant client library."
  homepage "https://pecl.php.net/package/tokyo_tyrant"
  url "https://pecl.php.net/get/tokyo_tyrant-0.7.0.tgz"
  sha256 "38559ac381670b61600d4736803a016f9e75aee9ae608d3f6b46e79103022d28"
  head "https://github.com/mkoppanen/php-tokyo_tyrant.git"

  bottle do
    sha256 "4c0e02dd15d25111b5a6704543f8512d8d2977f1ec3107555c159c481c6ca9e3" => :el_capitan
    sha256 "3a6047b4875ab2f55d825fd855617d78bc544f5ced37acf0ce33bf5cf03388ad" => :yosemite
    sha256 "e406c50b18a44eb3350a89592778129d7770455479903672f7854fa9b92d20de" => :mavericks
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
