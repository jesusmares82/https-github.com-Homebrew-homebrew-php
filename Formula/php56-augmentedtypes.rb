require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Augmentedtypes < AbstractPhp56Extension
  init
  homepage 'https://github.com/box/augmented_types'
  url 'https://github.com/box/augmented_types/archive/v0.6.6.tar.gz'
  sha256 '54b295f902e56daf1347b1e1f7d633a84c3e03aacac78424e6314adfd922e4db'
  head 'https://github.com/box/augmented_types.git'

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "65ca5e24420e1400fcbb1b5a519463c70218a96938193ea22d2839f0925038aa" => :el_capitan
    sha256 "2ed0a020a7ad9db49660d5f27629bbc46d377d6dd9603337c7f2461451bbadb7" => :yosemite
    sha256 "d08293b8aabf4bb3a44bdd2718f35c5e2e6d4fd84107e4f779565807ed5f21f1" => :mavericks
  end

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
