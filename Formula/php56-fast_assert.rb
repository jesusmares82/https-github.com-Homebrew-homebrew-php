require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56FastAssert < AbstractPhp56Extension
  init
  desc "Provides a nice way of making Assertions in php."
  homepage "https://github.com/box/fast_assert"
  head "https://github.com/box/fast_assert.git"

  def extension
    "fast_assert"
  end

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-fast_assert"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"

    prefix.install ["modules/fast_assert.so"]
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("fast_assert")
  end
end
