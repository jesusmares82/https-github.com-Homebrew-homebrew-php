require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Grpc < AbstractPhp55Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.3.2.tgz"
  sha256 "5ebb79868857155471b563751fb726b45da18e5a5708878253937bae0e629a84"

  bottle do
    cellar :any_skip_relocation
    sha256 "513d371ccd1050a9d324483047d8f2522df0d92a41ac45ddebf3f31b6b0db9b0" => :sierra
    sha256 "0ae29746018ae2404787264e11e9573ae7ec6161c5bad5657308d700dfc5c353" => :el_capitan
    sha256 "12b2bce76c7e9ce925e31e5f47e6edbbac6775f983facf22f79f13f03f04c048" => :yosemite
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
