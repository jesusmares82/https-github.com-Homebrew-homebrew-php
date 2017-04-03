require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Grpc < AbstractPhp70Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.2.0.tgz"
  sha256 "df205473888ad711e6c49df51732afee3e4fbcdd8dd717497531b733b22dd4ac"

  bottle do
    cellar :any_skip_relocation
    sha256 "f3ae25ac43039cf22e43e7bf4e70d0455592a1695e5517ae96c1afc70829e3a6" => :sierra
    sha256 "b8b045246df42501f3108dc0e06cab7156572fc05ed684dc39d400469face126" => :el_capitan
    sha256 "3eeadc408a086863ec639c2d5bc63cd5c253b21cd28de0539ed20b0d5bb5be8b" => :yosemite
  end

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc=#{HOMEBREW_PREFIX}",
           "--prefix=#{prefix}", phpconfig,
           "CFLAGS=-Ithird_party/boringssl/include"
    system "make"
    prefix.install "modules/grpc.so"
    write_config_file if build.with? "config-file"
  end
end
