require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Boxwood < AbstractPhp54Extension
  init
  homepage "https://github.com/ning/boxwood"
  url "https://github.com/ning/boxwood/archive/888ba12635d7c50cb1bbf1cbef513b0ef9238af3.tar.gz"
  sha256 "7e5142706023c4acc1db433998d2350458b00c7bc79eba0cc886683bba6b5343"
  version "888ba12"

  bottle do
    cellar :any_skip_relocation
    sha256 "93af27a84375b67a29c69ed0d96f218386dce2c586fb3d98aafaa9af04d33995" => :el_capitan
    sha256 "f7fa2e5a4013f0d2b1b8261e8c49df724b976dcb5985b839be8c8ecd5797bb1c" => :yosemite
    sha256 "5703526ac54198cd00372fbbf62b822b1d5d2b88eaf009c8bdfa1f7dc720b392" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig

    system "make"
    prefix.install "modules/boxwood.so"
    write_config_file if build.with? "config-file"
  end
end
