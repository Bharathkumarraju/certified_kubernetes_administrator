Lets say for example:
------------------------->
we have Five replicas of our web application instance deployed.

Recreate Strategy:
----------------------------------->
One way to upgrade these to a newer version is to destroy all of these and create newer versions of application instances

Meaning, First destroy the five running instances and then deploy five new instances of the newer application version.
The problem with this is that during the period
after the older versions are down and before the newer version up the application is down and in accessible to users,
this strategy is called recreate strategy and thankfully this is not the default deployment strategy.

Rolling update:
------------------------------------->
The second strategy is where we did not destriy all of them at once.
instead we take down the older version and bring up newer version one by one.
This way the application never goes down and the upgrade is seamless.

if you do not specify a strategy while creating the deployment it will assume it to be rolling update.
so rolling update is the default deployment strategy.







