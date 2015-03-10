require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdebug < AbstractPhp55Extension
  init
  homepage "http://xdebug.org"
  url "http://xdebug.org/files/xdebug-2.2.7.tgz"
  sha1 "587d300b8df0d1213910c59dda0c4f5807233744"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "45a50514875723d5d201cbb0dc33449334b85aa6a007cdcf387130903368c4c5" => :yosemite
    sha256 "68d4bf3d86a0943e53cd40e2ab4738a18ea6be1b5274acf1fb66e97c93d088e2" => :mavericks
    sha256 "08f3a36cd36ab5ceb64c9b2c4687f0e2de3bd2448d2a30afe6c3345b46c66589" => :mountain_lion
  end

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
