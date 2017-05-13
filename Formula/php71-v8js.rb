require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71V8js < AbstractPhp71Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-1.4.0.tgz"
  sha256 "c9401ed72a14e332661f64516d7ab13fe39c726e9c283cb3c81ccd786309494a"

  bottle do
    cellar :any
    sha256 "8c5a9081f6c7e23f40be9d3a949799a0ebc0c16746a6c4fb8ea82276e97ec201" => :sierra
    sha256 "103bfd11848e084066bea777313fa83706379e9653a551284c52cd00ceb29c11" => :el_capitan
    sha256 "8ad02af2becbfcac2363dc283eda17b515bc80fe6dee673d67bdc439d891033d" => :yosemite
  end

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
