import React from 'react'
import { useState } from 'react'
export default function Home() {
    const [imageFile, setImageFile]=useState();
    async function handleImageUpload(e){
        setImageFile(e.target.files[0]);
        await submit();
    }
    function submit(){
        const myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/json");
        const raw = JSON.stringify({
            "user": { description: "bla bla", image: imageFile }
        });

        const requestOptions = {
            method: "POST",
            headers: myHeaders,
            body: raw,
            redirect: "follow"
        };

        fetch("http://localhost:3000/posts", requestOptions)
            .then((response) => console.log("response: ", response))
            // .then((result) => {
            //     console.log("result: ", result);
            // })
            .catch((error) => console.log("error: ", error));
    }
    return (
        <>
            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="file_input">Upload file</label>
            <input class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="file_input" type="file" onChange={handleImageUpload}/>
        </>
    )
}
