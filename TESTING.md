ChefDK
-------
Install the chefDK to be able to test properly the cookbook (https://docs.chef.io/install_dk.html).

Style Testing
-------------

Ruby style tests can be performed by Rubocop by issuing
```
chef exec rubocop
```

Chef cookbook style tests can be performed with cookstyle by issuing
```
chef exec cookstyle
```

Chef style tests can be performed with Foodcritic by issuing
```
chef exec foodcritic
```

Spec Testing
-------------
Unit testing is done by running Rspec examples. Rspec will test any
libraries, then test recipes using ChefSpec. This works by compiling a
recipe (but not converging it), and allowing the user to make
assertions about the resource_collection.

Unit testing can be performed with Foodcritic by issuing
```
chef exec rspec
```

Coverage Testing
-----------------
Coverage testing is done by running coveralls examples.

Unit testing can be performed with Foodcritic by issuing
```
chef exec coveralls
```

Integration Testing using Docker
---------------------------------
Integration testing is performed by Test Kitchen. Test Kitchen will
use either the Vagrant driver or various cloud drivers to instantiate
machines and apply cookbooks. After a successful converge, tests are
uploaded and ran out of band of Chef. Tests should be designed to
ensure that a recipe has accomplished its goal.

Integration tests using Vagrant can be performed with either
```
chef exec kitchen test
```
