import React from 'react'
import { useState } from 'react'
export default function Home() {
    const [images, setImages] = useState();
    const [description, setDescription] = useState("");

    const handleImageChange = (e) => {
        setImages(e.target.files);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        const formData = new FormData();
        formData.append('post[description]', description);

        // Append multiple images to the form data
        for (let i = 0; i < images.length; i++) {
            formData.append('post[images][]', images[i]);
        }

        try {
            const response = await fetch('http://localhost:8000/posts', {
                method: 'POST',
                body: formData,
            });

            if (!response.ok) {
                const errorData = await response.json();
                console.error(errorData.errors);
            } else {
                const data = await response.json();
                console.log(data.message);
            }
        } catch (error) {
            console.error('Error:', error);
        }
    };

    // async function handleImageUpload(e) {
    //     e.preventDefault();
    //     const imageUploadPromise=new Promise((resolve, reject)=>{
    //         const file =e.target.files[0];
    //         resolve(file);
    //     })
    //     imageUploadPromise.then((value)=>{
    //         console.log("promise value: ", value);
    //         setImageFile(value);
    //         console.log("image: ",imageFile);
    //     })
    //     // console.log("image: ",e.target.files[0]);
    //     submit();
    // }
    // function submit() {
    //     const myHeaders = new Headers();

    //     const formdata = new FormData();
    //     formdata.append("post[description]", "5th post");
    //     formdata.append("post[user_id]", "1");
    //     formdata.append("post[video]", imageFile);
    //     for (let pair of formdata.entries()) {
    //         console.log(`${pair[0]}: ${pair[1]}`);
    //     }

    //     const requestOptions = {
    //         method: "POST",
    //         headers: myHeaders,
    //         body: formdata,
    //         redirect: "follow"
    //     };

    //     fetch("http://localhost:8000/posts", requestOptions)
    //         .then(async (response) => await response.json())
    //         .then((result) => {
    //             console.log("result: ", result);
    //         })
    //         .catch((error) => console.log("error: ", error));
    // }
    return (
        <>
            {/* <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="file_input">Upload file</label>
            <input class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="file_input" type="file" onChange={handleImageUpload} /> */}


            <form onSubmit={handleSubmit}>
                <div>
                    <label>Description:</label>
                    <textarea
                        value={description}
                        onChange={(e) => setDescription(e.target.value)}
                    />
                </div>
                <div>
                    <label>Images:</label>
                    <input type="file" multiple onChange={handleImageChange} />
                </div>
                <button type="submit">Create Post</button>
            </form>
        </>
    )
}
