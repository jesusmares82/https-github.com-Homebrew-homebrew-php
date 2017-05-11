require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Grpc < AbstractPhp70Extension
  init
  desc "The PHP extension for the gRPC library"
  homepage "http://grpc.io"
  url "https://pecl.php.net/get/grpc-1.3.2.tgz"
  sha256 "5ebb79868857155471b563751fb726b45da18e5a5708878253937bae0e629a84"

  bottle do
    cellar :any_skip_relocation
    sha256 "497a703a57f8a857774b6f828636e5d5a3655850b9caf3510b6b465a3bbb6fa0" => :sierra
    sha256 "f1ae8d25801f79da5da63c3d6df8afb9ed6ef2e699bd5a040564cae5f210f6cc" => :el_capitan
    sha256 "6231c14264412736c3fdfa8ba116bf558dfa58f1fc36548cd45a53997f512b7d" => :yosemite
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
