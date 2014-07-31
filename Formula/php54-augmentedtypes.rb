require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Augmentedtypes < AbstractPhp54Extension
  init
  homepage 'https://github.com/box/augmented_types'
  url 'https://github.com/box/augmented_types/archive/v0.6.2.tar.gz'
  sha1 'fcb4223b94f4af09d9a8fa67917e945f89faafe5'
  head 'https://github.com/box/augmented_types.git'

  def extension_type; "zend_extension"; end

  def extension
    "augmented_types"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-augmented_types"
    system "make"
    prefix.install "modules/augmented_types.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent
      augmented_types.enforce_by_default = 1
    EOS
  end
end
