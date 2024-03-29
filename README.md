# PassGen

Swift CLI app for generating passwords.

## Use
Run the app with the flag `-h` to see root level options. The app supports normal (random character string) and separated (random grouped characters separated by a separator character) password types.
<img width="1082" alt="Screenshot 2022-08-15 at 15 29 19" src="https://user-images.githubusercontent.com/1213228/184645800-22a75a98-e074-4800-b67e-c08792f6c83f.png">

### Normal
<img width="1082" alt="Screenshot 2022-08-15 at 15 29 29" src="https://user-images.githubusercontent.com/1213228/184645939-6d384291-e8aa-489f-80dc-371cc30dfc57.png">

<img width="1082" alt="Screenshot 2022-08-15 at 15 30 50" src="https://user-images.githubusercontent.com/1213228/184645986-e44dff3e-165a-456a-9577-80dcd173fc4e.png">


### Separated
<img width="1082" alt="Screenshot 2022-08-15 at 15 29 39" src="https://user-images.githubusercontent.com/1213228/184646034-b5316d5a-7f63-45af-ba96-a3f04a99b133.png">

<img width="1082" alt="Screenshot 2022-08-15 at 15 32 01" src="https://user-images.githubusercontent.com/1213228/184646057-a6b0c1b1-78f1-4c35-9994-01cd2871bdd6.png">


## Test
Run `swift test` to run the unit test suite
<img width="1082" alt="Screenshot 2022-08-15 at 15 34 09" src="https://user-images.githubusercontent.com/1213228/184646122-561fcebe-3ab6-47cb-98db-36d920be3aec.png">

## Build
To build an executable version of the app run `swift build -c release`
<img width="1082" alt="Screenshot 2022-11-09 at 23 29 30" src="https://user-images.githubusercontent.com/1213228/200956205-9c297f9c-050f-4e56-a74f-9b24c2dce909.png">

## Run
Move the executable to `/usr/local/bin` and run with `PassGen`
<img width="1082" alt="Screenshot 2022-11-09 at 23 28 19" src="https://user-images.githubusercontent.com/1213228/200956381-1c38e457-d18a-4a12-824d-7dbc66424ddb.png">
