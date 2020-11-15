# my_vet_tv

Paws N Claws

![alt text](https://github.com/bminton3/Paws-N-Claws/blob/master/assets/pawsNClawsFirst.jpg)

TODO:
1. Ads
2. Digital Signage - Display Monkey. Check out different open source code bases.
2. automatically create thumbnails from videos
3. automatically create objects from videos in assets
4. plug in cat and other pet buttons - done
5. change video selections based on pet age
6. Segment - use for analytics

How to upload to TestFlight (taken from https://flutter.dev/docs/deployment/ios):
0. You may need to clean cache folders in /var/folders: sudo rm -dfr *
1. In app directory, run 'flutter build ios'
2. Open Xcode, increment the Build number under Runner>General. then do product>archive
3. After creating archive, validate it in the archive popup
4. Upload it

Adding assets:
1. Add the asset to the assets folder in the project.
2. Update pubspec.yaml to include the new assets (if it's a folder).

Flutter sdk not found?
	Flutter upgrade —force 
    
