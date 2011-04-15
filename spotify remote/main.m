//
//  main.m
//  spotify remote
//
//  Created by orta on 15/04/2011.
//  Copyright 2011 http://www.ortatherox.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
  return macruby_main("rb_main.rb", argc, argv);
}
