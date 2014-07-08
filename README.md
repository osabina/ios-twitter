ios-twitter
========

Twitter app for iOS class (Assignment #3)

**Completed User Stories**
#### Required
- [x] User can sign in using OAuth login flow 
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh
- [x] User can compose a new tweet by tapping on a compose button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

#### Optional
- [] When composing, you should have a countdown in the upper right for the tweet limit.
- [] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [] Retweeting and favoriting should increment the retweet and favorite count.
- [] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [] Replies should be prefixed with the username and the reply_id should be set when posting the tweet
- [] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

**UI Demo**

![demo gif](https://raw.githubusercontent.com/osabina/ios-twitter/master/rt_demo.gif)

**Notes**

This took me ~12 hours (plus a couple of hours stuck on below :( ).

I had to stub the user display info for the compose view.  For some reason I kept losing my model data and after hours of banging my head against the wall, I gave up.

Also never completely got the table cells to shrink properly.

**Credits**

Uses the following CocoaPods:

- AFNetworking
- BDBOAuth1Manager
- DateTools
- EGOTableViewPullRefresh
- MBProgressHUD

Icons from http://icons8.com/

Additionally, demo gif captured with [LiceCap](http://www.cockos.com/licecap/)
