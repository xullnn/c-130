## Blocks

### Closures in Ruby

A closure is a general programming concept that allows programmers to save a "chunk of code" and execute it at a later time. It's called a "closure" because it's said to bind its surrounding artifacts (ie, variables, methods, objects, etc) and build an "enclosure" around everything so that they can be referenced when the closure is later executed.

- a general programming concept, so not only ruby has
- should know the reason of why it's called closure

In Ruby, a closure is implemented through a Proc object. That is, we can **pass around a Proc object as a "chunk of code" and execute it later**.

```ruby
def a_method(&block)
  p block.class
end

a_method # => NilClass

a_method { } # => Proc
```

The only thing to remember is that this Proc object or "chunk of code" retains references to its surrounding artifacts -- its **binding**.

What are the 3 ways to work with closure in Ruby?

---

### Calling Methods with Blocks

When we are calling a method followed by a block, be aware of:
- what's the method receiver
- what's the method you are calling
- which part is the block? No matter how large the block looks, it's actually an argument being passed to the method(important).

**What can you do within a block?**

- what's the relationship between the passed in block and the return value of the method?
- Will the block always affect the return value of the method?
- What is the determinative factor which decides the return value of the method?

The answer lies in how each of those methods are implemented. Remember that the code we wrote in the block is not the method implementation -- in fact, that code has nothing to do with the method implementation. The entire block is passed in to the method like any other argument, and it's up to the method implementation to decide what to do with the block, or chunk of code, that you passed in. The method could take that block and execute it, or just as likely, it could completely ignore it -- it's up to the method implementation to decide what to do with the block of code given to it.

---

### Writing Methods that take Blocks

Blocks are arguments passed to method, but it's a bit different with normal arguments.

```ruby
def greet
  'Hello!'
end

greet # => 'Hello!'

greet('Good morning!') # => ArgumentError

greet { p 'Good morning!' } # => 'Hello!'
```

In Ruby, every method can take an optional block as an **implicit parameter**.

One way that we can invoke the passed-in block argument from within the method is by using the `yield` keyword.

- The number of arguments at method invocation needs to match the method definition, regardless of whether we are passing in a block.
- The `yield` keyword executes the block.

If your method implementation contains a `yield`, a developer using your method can come in after this method is fully implemented and inject additional code in the middle of this method (without modifying the method implementation), by passing in a block of code.

- In what scenario a `LocalJumpError` will be raised?
- How to avoid this kind of situation?
- How to implement a method can be called with or without a followed block? (Two ways)

**Yielding with an argument**

Sometimes, the block we pass in to a method requires an argument. Note that the block itself is an argument into a method, so the fact that the block requires an argument adds an additional layer of complexity.

```ruby
3.times do |num|
  puts num
end
```

And the `do ... end` is the block. The num variable between the two `|`'s is a parameter for the block, or, more simply, a **block parameter**. Within the block, `num` is a **block local variable**. This is a special type of local variable where the scope is constrained to the block.

The rules around enforcing the number of arguments you can call on a closure in Ruby is called its `arity`. In Ruby, blocks have lenient `arity` rules, which is why it doesn't complain when you pass in different number of arguments.
- extra arguments passed to block will be ignored
- insufficient arguments will be taken as many as the block parameters can, the extra block parameters will be set to `nil`

**return value of block**

Another behavior of blocks that's similar to normal methods: they have a return value, and that return value is determined based on the last expression in the block.

**When to use blocks in your own methods**

1. Defer some implementation code to method invocation decision.

With a block which can be called optionally in a method definition, the method implementor give part of autonomy to the method caller(the person who are using this method). Thus makes the method more flexible.

If you encounter a scenario where you're calling a method from multiple places, with one little tweak in each case, it may be a good idea to try implementing the method in a generic way by yielding to a block.

2. Methods that need to perform some "before" and "after" actions - **sandwich code**.

The method implementor only care about what the method would do at some certain points at method invocation time -- for example, it only care about what 'the beginning of the method' and 'the end of the method' would do, in the middle? it doesn't care, that's where the block comes in -- so the caller can do anything in the middle of the method by writing code in the block.

### Methods with an explicit block parameter

The `&block` is a special parameter that converts the block argument to what we call a "simple" `Proc` object. Notice that we drop the `&` when referring to the parameter inside the method.

```ruby
def a_method(&block)
  p block.class
end

a_method # => NilClass

a_method { } # => Proc

proc_obj = Proc.new { p "In the proc." }

a_method(proc_obj) # => ArgumentError
```

Though `&` will convert the passed block, if has any, into a `Proc` object, but under this syntax we cannot pass a `Proc` object directly to the method, this will raise exception. If we want to pass a `Proc` object in, we need to define the method by the way it takes normal arguments.

```ruby
def a_method_may_take_proc(arg_1, a_proc)
  p arg_1
  a_proc.call
end

proc = Proc.new { }
a_method_may_take_proc('str', proc)
```

The block local variable is now a `Proc` object. Note that we can name it whatever we please; it doesn't have to be `block`, just as long as we define it with a leading `&`.

But by this way:
- we still can pass a block while calling the method
- but we can execute the block only by adding `yield` inside the method
- passed block cannot be explicitly captured by a variable in the method

So, `&something` syntax applied on the argument while defining a method:
- it doesn't mean this method requires an argument
  - if you pass anything other than a block(which is not an object), `ArgumentError` will be raised
- it doesn't mean you must give a block while calling it
  - how to use this converted-then-captured `proc` in the method depends on how we define the method itself, or how we use the proc, we can also choose not to `call` the proc at all.
- if we didn't give a block while invocation, the `something` inside the method will assigned to `nil`.

What's the difference between:
- implicitly accept a block and `yield` in the method
- using `&something` to turn a block into a `Proc` and capture this proc by `something` in the method

**summary for block**

- blocks are one way that Ruby implements closures. Closures are a way to pass around an unnamed "chunk of code" to be executed later.
- blocks can take arguments, just like normal methods. But unlike normal methods, it won't complain about wrong number of arguments passed to it.
- blocks return a value, just like normal methods.
- blocks are a way to defer some implementation decisions to method invocation time. It allows method callers to refine a method at invocation time for a specific use case. It allows method implementors to build generic methods that can be used in a variety of ways.
- blocks are a good use case for "sandwich code" scenarios, like closing a File automatically.

---

### Todo List `each`

Look carefully at the difference between the two method calls. It's `list.each` vs `list.todos.each`. In the first case, we're calling `TodoList#each`, whereas in the second case we're calling `Array#each`.

In most cases, we prefer to work with the `TodoList` object directly and invoke method calls on `list`. We would rather not access an internal state of the TodoList, which in this case is `@todos`. This is the idea behind **encapsulation**: we want to hide implementation details from users of the `TodoList class`, and not encourage users of this class to reach into its internal state. Instead, we want to encourage users of the class to use the interfaces (ie, public methods) we created for them.

For example, when we add a new todo into the list, we would rather use `TodoList#add`, rather than work with the `TodoList#todos` getter method and modify the array. The reason is because our TodoList class includes a rule: don't allow any item into the list that's not a `Todo` object. Therefore, we enforce this rule in `TodoList#add`. If we bypass that method, then all of a sudden that rule is no longer being enforced. Even if you can bypass it, allow the class implementer to enforce their rules; it's probably there for a reason.

Likewise, we prefer to use `TodoList#each` over reaching into the `@todos` array. Suppose later on we no longer want the internal representation to be an array. That is, `@todos` should be some other data structure (a linked list, a hash, etc). In that case, we'd need a different mechanism to iterate over the items in `TodoList` -- it can't be `Array#each` anymore, because it's no longer an array. Internal to the `TodoList` class, all we have to do is change the `TodoList#each` method. We'd need to figure out a new way to iterate through the linked-list, or hash, or whatever. **Users of the `TodoList` class shouldn't feel any change at all, if they use `TodoList#each`.** That method will still behave the same to users of the `TodoList` class; it will still iterate through the items, yielding each `Todo` object at every iteration. However, if users of the `TodoList` class had instead reached into the `@todos` variable directly (by way of using the getter method), then their code will break. Since `@todos` is no longer an Array, this code may no longer work: `list.todos.each { |todo| }`.

The entire goal of creating a class and encapsulating logic in a class is to hide implementation details and contain ripple effects when things change. Prefer to use the class's interface where possible.

---

### Blocks and Variable Scope

So even re-assigning the variable after the `Proc` is initialized updates the `chunk_of_code`. This implies that the `Proc` keeps track of its surrounding context, and drags it around wherever the chunk of code is passed to. In Ruby, we call this its **binding**, or surrounding environment/context. A closure must keep track of its surrounding context in order to have all the information it needs in order to be executed later.
- This is at the core of variable scoping rules in Ruby, and it's why "inner scopes can access outer scopes".

---

### Symbol to proc

- `&` first check if the thing behind it is a `Proc` object
  - if it is, turn it into a block
  - if it is not, first call `to_proc` on it to try converting it into a proc object
    - if succeeded turn it into block
    - if fail raise error

So the final purpose of `&` is try converting code behind it into a block, so the method then can utilize the block.

---

## Introduction to Testing

> rspec is a testing DSL. minitest is ruby.
    -- Adam Hawkins, "Bow Before MiniTest"

minitest doesn't reinvent anything that ruby already provides, like: classes, modules, inheritance, methods. This means you only have to learn ruby to use minitest and all of your regular OO practices like extract-method refactorings still apply.

http://docs.seattlerb.org/minitest/index.html

Why Write Tests?
- For beginners, write tests to **prevent regression** -- that's it!

Though many people use RSpec, Minitest is the default testing library that comes with Ruby. From a pure functionality standpoint, Minitest can do everything RSpec can, except Minitest uses a more straight forward syntax. RSpec bends over backwards to allow developers to write code that reads like natural English, but at the cost of simplicity.

RSpec is what we call a Domain Specific Language; it's a DSL for writing tests.

We use Minitest because it reads just like normal Ruby code, without a lot of magical syntax. It's not a DSL, it's just Ruby.

Within our test class, `CarTest`, we can write tests by creating an instance method that starts with `test_`. Through this naming convention, Minitest will know that these methods are individual tests that need to be run. Within each test (or instance method that starts with "`test_`"), we will need to make some assertions. These assertions are what we are trying to verify. Before we make any assertions, however, we have to first set up the appropriate data or objects to make assertions against.

### SEAT Approach

1. Set up the necessary objects.
2. Execute the code against the object we're testing.
3. Assert the results of the execution.
4. Tear down and clean up any lingering artifacts.

The `setup` method will be called before running every test, and the `teardown` method (which we don't have) will be called after running every test. In our case, we don't have any tear down activity, so it's not necessary. In some cases, we will need a tear down for cleaning up files or logging some information, or closing database connections.

**Testing equality**

When we use `assert_equal`, we are testing for value equality. Specifically, we're invoking the `==` method on the object. If we're looking for more strict object equality, then we need to use the `assert_same` assertion.

# From small problems / challenges

A lone `&` applied to an object causes ruby to try to convert the object to a block. If that object is a proc, the conversion happens automagically, just as shown above. If the object is not a proc, then `&` attempts to call the `#to_proc` method on the object first. Used with symbols, e.g., `&:to_s`, Ruby creates a proc that calls the `#to_s` method on a passed object, and then converts that proc to a block. This is the "symbol to proc" operation (though perhaps it should be called "symbol to block").

What is 'method to proc'? How to do this?

https://launchschool.com/exercises/ecdb2b22

**Comparison among proc, lambda and block**

- Lambdas are types of `Proc`'s. Technically they are both `Proc` objects. An implicit block is a grouping of code, a type of closure, it is not an Object.
- Lambdas enforce the number of arguments passed to them. Implicit blocks and `Proc`s do not enforce the number of arguments passed in.

***Dismantle Symbol#to_proc***

A normal version:

```ruby
['hello', 'world'].map(&:upcase)
# => ["HELLO", "WORLD"]
```

Wordier version:

```ruby
['hello', 'world'].map { |word| word.upcase }
```

More wordier version:

```ruby
['hello', 'world'].map { |word| word.public_send(:upcase) }
```

So how to make `&:upcase` do the work of `{ |word| word.public_send(:upcase) }`

More generally, how to make `:symbol`'s `to_proc` method to return a proc like `{ |x| x.public_send(:symbol) }`

```ruby
class Symbol
  def to_proc
    # return a proc that will public send self to every block argument(no matter what the argument is)
    # 'self' here is the symbol instance itself
      # so if we are using :to_s.to_proc, we will send :to_s(self) to every block argument
  end
end
```

Based on that:

```ruby
class Symbol
  def to_proc
    puts "Calling to_proc from #{self.class}!"
    proc { |x| x.public_send(self) }
  end
end

['hello', 'world'].map(&:upcase)
```

Will get:

```
Calling to_proc from Symbol!
 => ["HELLO", "WORLD"]
```

## Core Ruby Tools

On Mac, Ruby is originally carried by the MacOS, we can check the version by calling `/usr/bin/ruby -v` in terminal:

```
ruby 2.3.7p456 (2018-03-28 revision 63024) [universal.x86_64-darwin17]
```

- The Mac system Ruby has a characteristic that makes it undesirable for developers: it needs root access to install and manipulate other Ruby components. Root access is a privileged user level that isn't always available to the developer, so the developer lacks the permissions needed to easily install these components. That's a real hardship.

- You can determine where your system finds the ruby command with `which ruby`.

```
/Users/caven/.rvm/rubies/ruby-2.5.0/bin/ruby
```

Note that the Mac system Ruby is not what we are using by default.
- This shows the path name of the file that will run when you type ruby. Giving the path is the easiest way to tell which Ruby you are running.
- The presence of the word "rvm" means you are using a version of Ruby installed by the RVM Ruby version manager. Note that this path name also shows you which Ruby version is now active.
- To determine what version of Ruby is current, run `ruby -v`
```
ruby 2.5.0p0 (2017-12-25 revision 61468) [x86_64-darwin17]
```

All versions of Ruby since version 1.9 supply gem as part of the standard installation. So, you probably don't have to do anything special to get RubyGems if you're using a modern version of Ruby.

Run `gem env` to get the information about RubyGems installation.

Each version of Ruby on your system has its own `gem` command; if you have multiple versions of Ruby installed, then you have multiple versions of gem installed.

Under the context of `.rvm` directory, we can see the top level directories are `rubies` and `gems`

What are Gems?

RubyGems, often just called Gems, are packages of code that you can download, install, and use in your Ruby programs or from the command line. The gem command manages your Gems; all versions of Ruby since version 1.9 supply gem as part of the standard installation. So, you probably don't have to do anything special to get RubyGems if you're using a modern version of Ruby.
```
$ gem env
```

This prints a longish list of information about your RubyGems installation. Some of the more pertinent information produced by this command looks like this:

RubyGems Environment:
 - RUBYGEMS VERSION: 2.4.8
 - RUBY VERSION: 2.2.4 (2015-12-16 patchlevel 230) [x86_64-linux]
 - INSTALLATION DIRECTORY: /usr/local/rvm/gems/ruby-2.2.4
 - RUBY EXECUTABLE: /usr/local/rvm/rubies/ruby-2.2.4/bin/ruby
 - EXECUTABLE DIRECTORY: /usr/local/rvm/gems/ruby-2.2.4/bin
   ...
 - REMOTE SOURCES:
    - https://rubygems.org/
 - SHELL PATH:
    - /home/ubuntu/.nvm/versions/node/v4.5.0/bin
    - /usr/local/rvm/gems/ruby-2.2.4/bin
    - /usr/local/rvm/gems/ruby-2.2.4@global/bin
    ...

Let's look at some of these settings:

RUBY VERSION

This is the version number of the Ruby **associated with the `gem` command you just ran. Each version of Ruby on your system has its own gem command**; if you have multiple versions of Ruby installed, then you have multiple versions of gem installed. Checking the RUBY VERSION is a helpful diagnostic: if you see an unexpected version, you are likely using the wrong version of gem or ruby.

RUBY EXECUTABLE

This is the location of the ruby command that you should use with the Gems managed by this gem command. This information is often useful when RUBY VERSION reveals a gem/ruby mismatch.

INSTALLATION DIRECTORY

This directory is where gem installs Gems by default.

Let's look at this structure visually. Note that the following shows the directory structure under RVM; the structure will be different but similar with rbenv or a system ruby. The below diagram shows a RVM-managed Ruby version 2.2.4, with the bundler, freewill, pry, and rubocop gems installed.

Figure 1

```
$ tree /usr/local/rvm      # the following is partial output
/usr/local/rvm
├── gems
│   └── ruby-2.2.4        # This is the INSTALLATION DIRECTORY for Gems
│       ├── bin
│       │   ├── bundle
│       │   └── rubocop
│       └── gems
│           ├── bundler-1.12.5
│           ├── freewill-1.0.0
│           │   └── lib
│           │       └── freewill.rb
│           ├── pry-0.10.4
│           └── rubocop-0.43.1
└── rubies
   └── ruby-2.2.4
       └── bin
           ├── gem
           ├── irb
           └── ruby
```

- Under the `/rubies`, there're files relating to different Ruby languages.
- Under the `/gems` there're also different directories named by many Ruby versions, and inside every ruby-version directory, there are:
  - `/bin` directory which contains the commands relating to gems you can use in terminal when the specified version of Ruby is currently used
  - `/gems` contains various gems core files, but these gems are installed under the context of the specific Ruby version

To simplify the structure
```
- .rvm/
  - gems/ # gems are organized by diff Ruby versions
    - ruby-2.2.4/
      - bin/
        # gem related executables
      - gems
        - real gem files
    - ruby-2.3.2/
    - ruby-2.5.0/

  - rubies/
    - ruby-2.3.2/
      - bin/
        # Ruby related executables
    - ruby-2.5.0/
    # many Ruby versions
```

Note that the Gems are installed within a specific Ruby version; in this way, it's possible to install the same Gem for multiple Rubies because they are installed under the Ruby version-specific directory.

When you run `rvm use VERSION` to change the Ruby version you want to use, you actually invoke the `rvm` function. It modifies your **environment** so that the various ruby commands invoke the correct version. For instance, `rvm use 2.2.4` modifies your `PATH` variable so that the ruby command uses the Ruby installed in the ruby-2.2.4 directory. It makes other changes as well, but the `PATH` change is the most noticeable.

As we saw earlier, this command modifies your environment to ensure that the first ruby your system finds is version 2.2.4. This same change also works for related commands such as gem, irb and rubocop.

Suppose, though, that you want to use a different version of Ruby with one of your projects?
- manually use `rvm use x.x.x` while you are in the project directory, but you need to remember changing that back when you leave that directory, and changing again when you back into the project, thus back and forth. It's not complex, but it's easy to forget.
- There are several ways to do this, but the easiest is to create a `.ruby-version` file in your project's root directory; the content of this file is just the version number of ruby that you want to use when using programs from that directory.
  - To make use of the `.ruby-version` file, RVM replaces the `cd` command from your shell with a shell function. This function invokes the real `cd` command, then checks for the `.ruby-version` file (it also checks for some other files we won't discuss). If it finds one of these files, it retrieves the version number from the file, and then modifies your environment in the same way the rvm function does. Thus, **every time you change directories with the cd command, RVM modifies your environment to run the proper Ruby version.**
-RVM also uses the `Gemfile` for ruby projects that use Bundler (described in the next chapter). If the `Gemfile` contains a `ruby` directive, RVM uses that version of ruby to run the program. Note, however, that **the `.ruby-version` file takes precedence.**

Dealing with dependencies -- multiple versions of Ruby and multiple versions of Gems -- is a significant issue in Ruby. A project may need a Ruby version that differs from your default Ruby. Even if it requires the same version of Ruby, it may need a different version of a RubyGem.

The most widely used **dependency manager** in the Ruby community, by far, is the Bundler Gem. This Gem lets you configure which Ruby and which Gems each of your projects need.

Bundler is a Gem, so you must use the `gem` command to install it. If you use a Ruby version manager, you must install the Gem in **each version of Ruby** for which you wish to use Bundler.

Once Bundler creates your Gemfile.lock, add:
```ruby
require 'bundler/setup'
```
to the beginning of your app, before any other Gems. (This is unneeded if your app is a Rails app).

`bundler/setup` first removes all Gem directories from Ruby's `$LOAD_PATH` global array. Ruby uses `$LOAD_PATH` to list the directories that it searches when it needs to locate a required file. When `bundler/setup` removes those directories from `$LOAD_PATH`, Ruby can no longer find Gems.

To fix this, `bundler/setup` reads `Gemfile.lock`; for each Gem listed, it adds the directory that contains that Gem back to `$LOAD_PATH`. When finished, require only finds the proper versions of each Gem. This ensures that the specific Gem and version your app depends on is loaded, and not a conflicting version of that Gem.

Unfortunately, you will surely encounter situations where you can't just add `require 'bundler/setup'` to the code, or the program itself may run code that has conflicting needs. When this happens, you need the often mysterious `bundle exec` command.

You can use `bundle exec` to run most any command in an environment that conforms to the Gemfile.lock versioning info.

```
Gem::LoadError: You have already activated rake 11.3.0, but your Gemfile requires rake 10.4.2. Prepending `bundle exec` to your command may solve this.
```

This error usually appears when you use a Gem command whose version differs from the Gem version in your Gemfile. For example, let's say your default version of `rake` is version `11.3.0`, but you're in a directory where the Gemfile wants version `10.4.2`.

When you run `rake` from the command line, your system will find and execute rake version `11.3.0`; your shell doesn't know about `Gemfiles`, so it just invokes the version of `rake` it finds in the `PATH`.

Discrepancies with `rake` and other executables are the main reason to use `bundle exec`; it's easy to find advice that says "always use bundle exec rake", and this is good advice. However, this problem can happen with other commands as well. Any Gem command that requires other Gems may load a Gem that conflicts with your app's requirements. `bundle exec` is the easiest way to fix this issue.

Bundler lets you describe exactly which Ruby and Gems you want to use with your Ruby apps. Specifically, it lets you install multiple versions of each Gem under a specific version of Ruby and then use the proper version in your app.

The `bundle exec` command ensures that executable programs installed by Gems don't interfere with your app's requirements. For instance, if your app needs a specific version of `rake` but the default version of `rake` differs, `bundle exec` ensures that you can still run the specific `rake` version compatible with your app.

`Rake` is a **Rubygem** that automates many common functions required to build, test, package, and install programs; **it is part of every modern Ruby installation**, so you don't need to install it yourself.

Rake uses a file named `Rakefile` that lives in your project directory; this file describes the tasks that Rake can perform for your project, and how to perform those tasks.

Note that we used `bundle exec rake -T`, not just `rake -T`. We discussed bundle exec in the previous chapter. Often, `rake -T` will work just fine, but many prefer to use `bundle exec` with rake when possible (i.e., when your project uses Bundler); if you don't, you may see unusual messages like this:
```
$ rake -T
rake aborted!
Gem::LoadError: You have already activated rake 12.0.0, but your Gemfile requires rake 10.4.2. Prepending `bundle exec` to your command may solve this.
```
This shows that your `Gemfile` requires a version of rake that differs from the version you get when you type rake at the command line. `bundle exec rake` makes sure that you use the correct version of rake that your application depends on.

If you see:
```
Could not locate Gemfile or .bundle/ directory
```
when using `bundle exec rake`, this means that your project isn't using Bundler. Here, you should omit `bundle exec` and just run `rake` instead.

Though we don't list these Gems in our `Gemfile`, the Gems we do list each have their own `Gemfile`, which, in turn, identifies their dependencies. Our project's dependencies have dependencies, too. By recursively scanning the `Gemfile`s for each Gem, Bundler builds a complete dependency list that identifies all the Gems your application needs, even those you don't know you need. Once Bundler has the dependency list, it installs any Gems that are not yet part of your Ruby installation.
