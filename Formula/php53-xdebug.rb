require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Xdebug < AbstractPhp53Extension
  init
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.2.7.tgz'
  sha1 '587d300b8df0d1213910c59dda0c4f5807233744'
  head 'https://github.com/xdebug/xdebug.git'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "f1f25dcf4bd5a119d8a11eebd82122a47348c670" => :yosemite
    sha1 "9a35843631103fc0d815a72e480fda7bb52d61b0" => :mavericks
    sha1 "37fb04e8256a25e022e1f418138872a32c9b54c7" => :mountain_lion
  end

  def extension_type; "zend_extension"; end

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
