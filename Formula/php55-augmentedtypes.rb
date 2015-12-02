require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Augmentedtypes < AbstractPhp55Extension
  init
  desc "A PHP extension to enforce parameter and return type annotations"
  homepage "https://github.com/box/augmented_types"
  url "https://github.com/box/augmented_types/archive/v0.6.6.tar.gz"
  sha256 "54b295f902e56daf1347b1e1f7d633a84c3e03aacac78424e6314adfd922e4db"
  head "https://github.com/box/augmented_types.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "1cedb1a0155aaf9fd6f3008cf919c5b3e7a514d6ca02a4a961ff1be70204c270" => :el_capitan
    sha256 "c4f67acb354a9604270477317f6b21145c374352f9236181c51c17577597347f" => :yosemite
    sha256 "f5ccc28075406266644f4aad3c0e9f594f00a8ac1e6825ef9f7dbae6ab0d5f94" => :mavericks
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
