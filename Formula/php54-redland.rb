require 'formula'
require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Redland < AbstractPhp54Extension
  init
  homepage 'http://librdf.org'
  url 'http://download.librdf.org/source/redland-bindings-1.0.17.1.tar.gz'
  sha256 'ff72b587ab55f09daf81799cb3f9d263708fad5df7a5458f0c28566a2563b7f5'

  depends_on 'pkg-config' => :build
  depends_on 'redland'
  depends_on 'raptor'
  depends_on 'rasqal'

  fails_with :llvm do
    build 2334
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --with-php
      --with-php-linking=dylib
    ]

    system "./configure", *args
    system "make"
    prefix.install "php/#{extension}.dylib"
    write_config_file if build.with? "config-file"
  end

  def module_path
    prefix / "#{extension}.dylib"
  end
end
