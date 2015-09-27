require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Augmentedtypes < AbstractPhp54Extension
  init
  homepage "https://github.com/box/augmented_types"
  url "https://github.com/box/augmented_types/archive/v0.6.6.tar.gz"
  sha256 "54b295f902e56daf1347b1e1f7d633a84c3e03aacac78424e6314adfd922e4db"
  head "https://github.com/box/augmented_types.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "83f0e95c540388fab2548e18b8279565001d6109cf55f4eae6ebdf2be12be925" => :el_capitan
    sha256 "6968a9ea8ce161bac1022102b563970e3d6d35b960a90d06cb0b844d926ee3c1" => :yosemite
    sha256 "32a03fb59d2c79efc2fe9a290f6dddc9fc4bab85866377381e1cc1b88b811e7a" => :mavericks
  end

  option "without-default-enforcement", "Turn off Augmented Types enforcement by default"

  def extension_type
    "zend_extension"
  end

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
    if active_spec.build.with? "default-enforcement"
      super + <<-EOS.undent
        augmented_types.enforce_by_default = 1
      EOS
    else
      super
    end
  end
end
