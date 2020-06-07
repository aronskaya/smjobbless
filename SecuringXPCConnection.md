# Securing XPC Connection

It could be not obvious from the documentation, but the OS performs signature validation only in 2 cases:
* installation of the Privileged Helper
* update the previously installed Privileged Helper with a new version.

Important takeaway: no validation is performed on establishing XPC connection. It means, that any process on user's machine can connect to any Privileged Helper and call it's methods. Even a non-privileged process. Say, a malware can perform actions as root using any installed Privileged Helper.

## Privileged Helper: insecure by default

It is a flaw in Privileged Helpers' design, that the default implementation is highly vulnerable and leads to an easy privilege escalation scenario. Here is what you can do to protect your application.

## Securing XPC Connection

### Privileged Helper

1. Check the bundle identifier of the client, that wants to connect
2. Check, that the client is validly signed
3. [optional] Check for minimum version of the client (if you have old versions, that have no Hardened Runtime — and because of that are vulnerable for dylib injections)

The first 2 steps are implemented in this sample.

### Client
1. In order to prevent tampering with the Privileged Helper **before installation** Client should validate its own signature. If it is broken, do not install the Privileged Helper.
Example of signature validation could be found in `isValidClient(forConnection:)` method. 
2. Always have enabled Hardened Runtime and Library Validation in your project settings. It is the way to protect yourself from dylib injection (works only when System Integrity Protection is enabled).

The second step is implemented in this sample.

## See also
I have delivered a talk on security bugs in SMJobBless + XPC Connection setup at Objective by the Sea Mac Security Conference v3.0 on 13th of March, 2020. Slides are available on [SpeakerDeck](https://speakerdeck.com/vashchenko/job-s-bless-us-privileged-operations-on-macos). There you can find an example project setup and description of several bugs.

Other materials on the topic:
1. project-zero ‘[Issue 1223: MacOS/iOS userspace entitlement checking is racy](https://bugs.chromium.org/p/project-zero/issues/detail?id=1223)’ by
Ian Beer
2. OffensiveCon19 '[OSX XPC Revisited - 3rd Party Application Flaws](https://www.youtube.com/watch?v=KPzhTqwf0bA)' by Tyler Bohan
3. Apple Developer Forums '[XPC restricted to processes with the same code signing?](https://bugs.chromium.org/p/project-zero/issues/detail?id=1223)'
4. Objective Development ‘[The Story Behind CVE-2019-13013](https://blog.obdev.at/what-we-have-learned-from-a-vulnerability/)’ by Christian from Little Snitch
5. ‘[No Privileged Helper Tool Left Behind](https://erikberglund.github.io/2016/No_Privileged_Helper_Tool_Left_Behind/)’ by Erik Berglund

