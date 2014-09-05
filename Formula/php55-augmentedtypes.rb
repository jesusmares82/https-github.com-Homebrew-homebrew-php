require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Augmentedtypes < AbstractPhp55Extension
  init
  homepage 'https://github.com/box/augmented_types'
  url 'https://github.com/box/augmented_types/archive/v0.6.5.tar.gz'
  sha1 '5f96071aa9c0736d6eebf9d217f1348281397a97'
  head 'https://github.com/box/augmented_types.git'

  option 'without-default-enforcement', "Turn off Augmented Types enforcement by default"

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
    if active_spec.build.with? 'default-enforcement'
      super + <<-EOS.undent
        augmented_types.enforce_by_default = 1
      EOS
    else
      super
    end
  end
end
